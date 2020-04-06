// Polyfills should be imported before EVERYTHING
import "root/shared/polyfills";
import { hot } from "react-hot-loader/root";
import React from "react";
import ReactDOM from "react-dom";

import App from "./components/App";

import "./styles/base.css";

const HottestApp = hot(App);

window.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<HottestApp />, document.getElementById("root"));
});
