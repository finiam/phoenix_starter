import React, {
  createContext,
  ReactNode,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import type { Response } from "redaxios";
import { useHistory, useLocation } from "react-router-dom";
import * as sessionsApi from "root/api/sessions";
import * as usersApi from "root/api/users";

export interface AuthContextType {
  user: User;
  loading: boolean;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  error?: Response<any>;
  login: (email: string, password: string) => void;
  signUp: (email: string, name: string, password: string) => void;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType>({} as AuthContextType);

export function AuthProvider({
  children,
}: {
  children: ReactNode;
}): JSX.Element {
  const [user, setUser] = useState<User>();
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const [error, setError] = useState<Response<any> | null>();
  const [loading, setLoading] = useState<boolean>(false);
  const [loadingInitial, setLoadingInitial] = useState<boolean>(true);
  const history = useHistory();
  const location = useLocation();

  useEffect(() => {
    if (error) setError(null);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [location.pathname]);

  useEffect(() => {
    usersApi
      .getCurrentUser()
      .then((newUser) => setUser(newUser))
      .catch((_error) => {})
      .finally(() => setLoadingInitial(false));
  }, []);

  function login(email: string, password: string) {
    setLoading(true);

    sessionsApi
      .login({ email, password })
      .then((newUser) => {
        setUser(newUser);
        history.push("/");
      })
      .catch((newError) => setError(newError))
      .finally(() => setLoading(false));
  }

  function signUp(email: string, name: string, password: string) {
    setLoading(true);

    usersApi
      .signUp({ email, name, password })
      .then((newUser) => {
        setUser(newUser);
        history.push("/");
      })
      .catch((newError) => setError(newError))
      .finally(() => setLoading(false));
  }

  function logout() {
    sessionsApi.logout().then(() => setUser(undefined));
  }

  // Make the provider update only when it should
  const memoedValue = useMemo(
    () => ({
      user,
      loading,
      error,
      login,
      signUp,
      logout,
    }),
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [user, loading, error]
  );

  return (
    <AuthContext.Provider value={memoedValue as AuthContextType}>
      {!loadingInitial && children}
    </AuthContext.Provider>
  );
}

export default function useAuth(): AuthContextType {
  return useContext(AuthContext);
}
