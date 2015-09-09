module.exports =
  ipaddress: process.env.OPENSHIFT_NODEJS_IP
  port: process.env.OPENSHIFT_NODEJS_PORT or process.env.PORT or 8000
