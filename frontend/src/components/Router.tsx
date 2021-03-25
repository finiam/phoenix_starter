import React from "react";
import { Switch, Route, Redirect, RouteProps } from "react-router-dom";
import loadable from "@loadable/component";
import useAuth from "root/hooks/useAuth";

type AsyncRouteProps = RouteProps & { importPath: () => Promise<any> };

function AsyncRoute({ importPath, ...props }: AsyncRouteProps) {
  return <Route {...props} component={loadable(importPath)} />;
}

function AuthenticatedRoute(props: AsyncRouteProps) {
  const { user } = useAuth();

  if (!user) return <Redirect to="/login" />;

  return <AsyncRoute {...props} />;
}

export default function Router() {
  return (
    <Switch>
      <AuthenticatedRoute
        exact
        path="/"
        importPath={() => import("root/pages/HomePage")}
      />
      <AsyncRoute
        exact
        path="/login"
        importPath={() => import("root/pages/LoginPage")}
      />
      <AsyncRoute
        exact
        path="/sign_up"
        importPath={() => import("root/pages/SignUpPage")}
      />
    </Switch>
  );
}
