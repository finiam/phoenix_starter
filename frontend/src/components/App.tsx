import React from "react";
import { BrowserRouter } from "react-router-dom";
import { AuthProvider } from "root/hooks/useAuth";
import redaxios from "redaxios";
import Router from "./Router";

export default function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Router />
      </AuthProvider>
    </BrowserRouter>
  );
}

// Set your API baseUrl here
//
// @ts-ignore
if (import.meta.env.MODE === "development") {
  redaxios.defaults.baseURL = "http://localhost:4000";
  redaxios.defaults.withCredentials = true;
}
