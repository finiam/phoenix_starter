import React from "react";
import PropTypes from "prop-types";

import styles from "./index.module.css";

export default function Text({ children }) {
  return <p className={styles.root}>{children}</p>;
}

Text.propTypes = {
  children: PropTypes.node.isRequired,
};
