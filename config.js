var path = require('path'),
    config;

config = {
    // ### Production
    // When running Ghost in the wild, use the production environment.
    // Configure your URL and mail settings here
    production: {
        url: 'http://blog.example.com',
        database: {
            client: 'mysql',
            connection: {
                host: 'GHOST_DB_HOST',
                user: 'GHOST_USER',
                password: 'GHOST_PASSWORD',
                database: 'GHOST_DB',
                charset: 'utf8'
            }
        },
        storage: {
            active: 'gcloud',
            'gcloud': {
                projectId: 'api-project-274440984329',
                key: '/secrets/cloudstorage/assets.json', 
                bucket: 'ghost-assets'
            }
        },
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
