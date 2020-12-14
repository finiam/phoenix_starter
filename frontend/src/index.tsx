import React from "react";
import ReactDOM from "react-dom";
import redaxios from "redaxios";

import App from "root/components/App";

import "normalize.css";
import "./styles/base.css";

window.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<App />, document.getElementById("root"));
});

// @ts-ignore
if (import.meta.env.MODE === "development") {
  redaxios.defaults.baseURL = "http://localhost:4000";
}
