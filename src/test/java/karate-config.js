function fn() {
var env = karate.env;

if (!env) {
env = 'dev';
}

var config = {
env: env,
myVarName: 'Api Testing',
baseUrl: 'https://restful-booker.herokuapp.com',
}
 karate.log('karate.env system property was:', env);

if (env == 'dev') {
config.baseUrl='https://restful-booker.herokuapp.com',
} else if (env == 'e2e') {
config.baseUrl='https://restful-booker.herokuapp.com',
}
return config;
}