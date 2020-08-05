// Polyfills should be imported before EVERYTHING
import "./shared/polyfills";
import React from "react";
import ReactDOM from "react-dom";

import App from "./components/App";

import "./styles/base.css";

function Root() {
  return (
    <div>
      <App />
    </div>
  );
}

window.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<Root />, document.getElementById("root"));
});
