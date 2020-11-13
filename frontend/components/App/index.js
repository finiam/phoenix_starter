import React from "react";
import loadable from "@loadable/component";

import ServerResource from "root/components/ServerResource";
import potato from "root/assets/potato.jpg";

import styles from "./index.module.css";

// Code splitting, as an example
const Text = loadable(() => import("root/components/Text"));

export default function App() {
  return (
    <div className={styles.root}>
      <p>Hello World!</p>
      <Text>This is an async component</Text>
      <ServerResource />
      <img className={styles.image} src={potato} alt="potato" />
    </div>
  );
}
