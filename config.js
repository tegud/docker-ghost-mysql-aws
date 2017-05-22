var path = require('path'),
    config;

config = {
    // ### Production
    // When running Ghost in the wild, use the production environment.
    // Configure your URL and mail settings here
    production: {
        url: process.env.GHOST_URL,
        mail: {
            transport: 'SMTP',
            options: {
                service: 'Mailgun',
                auth: {
                    user: process.env.EmailUserName, // mailgun username
                    pass: process.env.EmailPassword // mailgun password
                }
            }
        },
        database: {
            client: 'mysql',
            connection: {
                host: 'mysql',
                user: 'GHOST_USER',
                password: 'GHOST_PASSWORD',
                database: 'GHOST_DB',
                charset: 'utf8'
            }
        },
        storage: {
            active: 's3',
            s3: {
                accessKeyId: process.env.AWS_KEY,
                bucket: process.env.AWS_BUCKET,
                region: process.env.AWS_REGION,
                secretAccessKey: process.env.AWS_SECRET
            }
        }
        server: {
            host: '0.0.0.0',
            port: '2368'
        },
        paths: {
            contentPath: path.join(__dirname, '/content/')
        }
    }
};

module.exports = config;
