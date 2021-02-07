import React from "react";
import ReactDOM from "react-dom";

import App from "./components/App";

import "normalize.css";
import "./styles/base.css";

window.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<App />, document.getElementById("root"));
});
