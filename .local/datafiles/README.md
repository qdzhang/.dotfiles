## How to use aria RPC server

Use aria2 and [web-ui](https://github.com/ziahamza/webui-aria2) to setup aria2 RPC server quickly

- Run following command to launch aria2 deamon with specific configuration file:

```bash
# Replace {user} with actual user name
aria2c --conf-path=/home/{user}/.local/datafiles/aria2.conf -D
```

- Clone [web-ui](https://github.com/ziahamza/webui-aria2), and run `node node-server.js` to open node server.
- Open url `http://localhost:8888/` in browser.
