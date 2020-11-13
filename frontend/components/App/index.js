import React, { useEffect, useRef } from "react";
import asyncImport from "react-imported-component";
import potato from "root/assets/potato.jpg";
import asyncImporter from "root/shared/asyncImporter";

import styles from "./index.module.css";

// Code splitting, as an example
const Text = asyncImporter(import("root/components/Text"));

export default function App() {
  const ref = useRef();

  useEffect(() => {
    window.ref = ref;
  });

  return (
    <div className={styles.root}>
      <p>Hello World!</p>
      <Text ref={ref}>This is an async component</Text>
      <img className={styles.image} src={potato} alt="potato" />
    </div>
  );
}
