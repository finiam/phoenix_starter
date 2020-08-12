// Polyfills should be imported before EVERYTHING
import "./shared/polyfills";
import React from "react";
import ReactDOM from "react-dom";

import App from "./components/App";

import "./styles/base.css";

window.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<App />, document.getElementById("root"));
});
