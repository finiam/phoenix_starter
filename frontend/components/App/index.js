import React from "react";
import asyncImport from "react-imported-component";
import potato from "root/assets/potato.jpg";

import styles from "./index.module.css";

// Code splitting, as an example
const Text = asyncImport(() => import("root/components/Text"));

function App() {
  return (
    <div className={styles.root}>
      <p>Hello World!</p>
      <Text>This is an async component</Text>
      <img className={styles.image} src={potato} alt="potato" />
    </div>
  );
}

export default App;
