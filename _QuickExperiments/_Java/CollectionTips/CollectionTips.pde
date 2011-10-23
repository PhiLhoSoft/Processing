String[] data = { "Processing", "is", "cool", "so", "is", "Java" };

// Immutable! Can't add/remove elements. OK to call an API
// But fast, use a simple wrapper, no copy of data
List<String> al1 = Arrays.asList(data);

// This one is flexible, but copy the data
ArrayList<String> al2 = new ArrayList<String>(al1); 

// Similar to al2
ArrayList<String> al3 = new ArrayList<String>(data.length); // Init at right size improves perf
Collections.addAll(al3, data); 

println(al1);
println(al2);
println(al3);

