/**
http://en.wikipedia.org/wiki/Vincenty%27s_formulae
Using "Direct and Inverse Solutions of Geodesics on the Ellipsoid
with application of nested equations" paper by Thaddeus Vincenty.

Exploiting the inverse solution here to compute the distance between two
geodesic points on the Earth (ellipsoid).

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 1.00.000 -- 2009/02/19 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicence.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2009 Philippe Lhoste / PhiLhoSoft
*/
package org.philhosoft.geometry;

/**
 * Calculates the distance on Earth (in meters) between two points, given their
 * latitude and longitude, in decimal degrees.
 * Uses the inverse formula for ellipsoid found by Vincenty.
 */
final static double ComputeVincentyDistance(double lat1, double lon1, double lat2, double lon2)
{
	// WGS-84 ellipsiod
	// a & b: major and minor semi-axes of the ellipsoid (in meters)
	double a = 6378137, b = 6356752.3142;
	// f: flattening
	double f = (a - b) / a;

	double deltaLon = Math.toRadians(lon2 - lon1);
	// Reduced latitude
	double u1 = Math.atan((1 - f) * Math.tan(Math.toRadians(lat1)));
	double u2 = Math.atan((1 - f) * Math.tan(Math.toRadians(lat2)));
	double sinU1 = Math.sin(u1), cosU1 = Math.cos(u1);
	double sinU2 = Math.sin(u2), cosU2 = Math.cos(u2);

	// Difference in longitude, on an auxiliary sphere
	// (first approximation)
	double lambda = deltaLon;
	double lambdaPrime = 2 * Math.PI, iterLimit = 100;
	do
	{
		double sinLambda = Math.sin(lambda), cosLambda = Math.cos(lambda);
		double sinSigma = Math.sqrt(cosU2 * sinLambda * cosU2 * sinLambda +
		(cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) * (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));
		if (sinSigma==0) return 0;	// co-incident points
		double cosSigma = sinU1*sinU2 + cosU1*cosU2*cosLambda;
		double sigma = Math.atan2(sinSigma, cosSigma);
		double sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
		double cosSqAlpha = 1 - sinAlpha*sinAlpha;
		double cos2SigmaM = cosSigma - 2*sinU1*sinU2/cosSqAlpha;
		if (isNaN(cos2SigmaM)) cos2SigmaM = 0;	// equatorial line: cosSqAlpha=0 (§6)
		double C = f/16*cosSqAlpha*(4+f*(4-3*cosSqAlpha));
		lambdaP = lambda;
		lambda = L + (1-C) * f * sinAlpha *
			(sigma + C*sinSigma*(cos2SigmaM+C*cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)));
	} while (Math.abs(lambda-lambdaP) > 1e-12 && --iterLimit>0);

	if (iterLimit==0) return NaN	// formula failed to converge

	double uSq = cosSqAlpha * (a*a - b*b) / (b*b);
	double A = 1 + uSq/16384*(4096+uSq*(-768+uSq*(320-175*uSq)));
	double B = uSq/1024 * (256+uSq*(-128+uSq*(74-47*uSq)));
	double deltaSigma = B*sinSigma*(cos2SigmaM+B/4*(cosSigma*(-1+2*cos2SigmaM*cos2SigmaM)-
		B/6*cos2SigmaM*(-3+4*sinSigma*sinSigma)*(-3+4*cos2SigmaM*cos2SigmaM)));
	double s = b*A*(sigma-deltaSigma);

	s = s.toFixed(3); // round to 1mm precision
	return s;
}


// extend String object with method for parsing degrees or lat/long values to numeric degrees
//
// this is very flexible on formats, allowing signed decimal degrees, or deg-min-sec suffixed by
// compass direction (NSEW). A doubleiety of separators are accepted (eg 3º 37' 09"W) or fixed-width
// format without separators (eg 0033709W). Seconds and minutes may be omitted. (Minimal validation
// is done).

String.prototype.parseDeg = function() {
	if (!isNaN(this)) return Number(this);								 // signed decimal degrees without NSEW

	double degLL = this.replace(/^-/,'').replace(/[NSEW]/i,'');	// strip off any sign or compass dir'n
	double dms = degLL.split(/[^0-9.]+/);										 // split out separate d/m/s
	for (double i in dms) if (dms[i]=='') dms.splice(i,1);		// remove empty elements (see note below)
	switch (dms.length) {																	// convert to decimal degrees...
		case 3:																							// interpret 3-part result as d/m/s
			double deg = dms[0]/1 + dms[1]/60 + dms[2]/3600; break;
		case 2:																							// interpret 2-part result as d/m
			double deg = dms[0]/1 + dms[1]/60; break;
		case 1:																							// decimal or non-separated dddmmss
			if (/[NS]/i.test(this)) degLL = '0' + degLL;			 // - normalise N/S to 3-digit degrees
			double deg = dms[0].slice(0,3)/1 + dms[0].slice(3,5)/60 + dms[0].slice(5)/3600; break;
		default: return NaN;
	}
	if (/^-/.test(this) || /[WS]/i.test(this)) deg = -deg; // take '-', west and south as -ve
	return deg;
}
// note: whitespace at start/end will split() into empty elements (except in IE)

// extend Number object with methods for converting degrees/radians

Number.prototype.toRad = function() {	// convert degrees to radians
	return this * Math.PI / 180;
}

