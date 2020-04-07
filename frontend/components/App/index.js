import React from "react";
import asyncImport from "react-imported-component";

import styles from "./index.module.css";

// Code splitting, as an example
const Text = asyncImport(() => import("root/components/Text"));

export default function App() {
  return (
    <div className={styles.root}>
      <p>Hello World!</p>
      <Text>This is an async component</Text>
    </div>
  );
}
