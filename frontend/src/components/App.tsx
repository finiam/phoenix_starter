import React from "react";
import { BrowserRouter } from "react-router-dom";
import { AuthProvider } from "root/hooks/useAuth";
import redaxios from "redaxios";
import Router from "./Router";

export default function App(): JSX.Element {
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
// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
redaxios.defaults.baseURL = import.meta.env.SNOWPACK_PUBLIC_API_URL || "/";
redaxios.defaults.withCredentials = true;
