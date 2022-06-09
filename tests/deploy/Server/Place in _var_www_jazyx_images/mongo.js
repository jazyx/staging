// <<<HARD-CODED
const ip_address = '127.0.0.1'
const port = 27017
const db_name = "staging"
// HARD-CODED >>>

const database = ip_address + ":" + port + "/" + db_name
const db = connect(database);

// Customize the code below
const collections = db.getCollectionNames();
collections.forEach(name => db[name].drop())