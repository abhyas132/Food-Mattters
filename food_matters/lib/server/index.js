const app = require('./app');
const connectWithDb = require('./config/db');

//connect with db
connectWithDb();

const PORT = process.env.PORT || 3000;
// const app = express()
// const DB = "mongodb+srv://abhyas132:abhyas132@cluster0.qcv2gij.mongodb.net/?retryWrites=true&w=majority"

// mongoose.connect(DB).then(() => {
//     console.log("Connection successful with mongoDB")
// }).catch((e) => {
//     console.log(e);
// })

app.listen(PORT, "0.0.0.0", () => {

    console.log(`connected at port ${PORT}`)
})

	console.log(`connected at port ${PORT}`);
})




