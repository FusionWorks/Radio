module.exports = {
  apps : [
    {
      name      : "Radio",
      script    : "node_modules/.bin/coffee bin/www",
      exec_interpreter: "none",
      env : {
        NODE_ENV: "production"
      }
    },
  ],
}
