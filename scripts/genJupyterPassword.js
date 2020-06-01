const crypto = require('crypto')

function jupyterPasswd(password) {
	const shasum = crypto.createHash('sha1')
	const saltLen = 12
	const max = Math.pow(2, 4 * saltLen)
	const salt  = Math.floor(Math.random() * Math.floor(max)).toString(16)
	shasum.update(password + salt)
	const hash = shasum.digest('hex')
	return 'sha1:' + salt + ':' +  hash
}


function encodeBase64(s) {
	return new Buffer(s).toString('base64')
}
function decodeBase64(sd) {
	return new Buffer(d, 'base64').toString()
}

if(process.argv.length < 3) {
	console.log("pass password as command line argument!")
	process.exit(1)
}

const arg = process.argv[2]
const passwd = jupyterPasswd(arg)
const passwdString = encodeBase64("c.NotebookApp.password = u'" + passwd +"'")
console.log(passwdString)
