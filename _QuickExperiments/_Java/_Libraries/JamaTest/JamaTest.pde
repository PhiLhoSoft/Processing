import Jama.*;

double[][] vals = {{1.,2.,3},{4.,5.,6.},{7.,8.,10.}};
Matrix A = new Matrix(vals);
Matrix b = Matrix.random(3,1);
Matrix x = A.solve(b);
Matrix r = A.times(x).minus(b);
double rnorm = r.normInf();

A.print(5, 2);
b.print(5, 2);
x.print(5, 2);
r.print(5, 2);

