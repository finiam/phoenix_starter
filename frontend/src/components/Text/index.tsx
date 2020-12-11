import React, { ReactNode } from "react";

import styles from "./index.module.css";

interface AppProps {
  children: ReactNode;
}

export default function Text({ children }: AppProps) {
  return <p className={styles.root}>{children}</p>;
}
