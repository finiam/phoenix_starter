/* eslint-disable import/no-extraneous-dependencies, no-console */

process.stdin.on("end", () => {
  console.log("Bye!");
  process.exit(0);
});

process.stdin.resume();

const { exec } = require("child_process");

const child = exec(`cd ${__dirname} && yarn dev`);

child.stdout.on("data", (data) => console.log(data));
child.stderr.on("data", (data) => console.error(data));
