import React, {
  createContext,
  ReactNode,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import { useHistory, useLocation } from "react-router-dom";
import * as sessionsApi from "root/api/sessions";
import * as usersApi from "root/api/users";

interface AuthContextType {
  user?: User;
  loading: boolean;
  error?: any;
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
  const [error, setError] = useState<any>();
  const [loading, setLoading] = useState<boolean>(false);
  const [loadingInitial, setLoadingInitial] = useState<boolean>(true);
  const history = useHistory();
  const location = useLocation();

  useEffect(() => {
    if (error) setError(undefined);
  }, [location.pathname]);

  useEffect(() => {
    usersApi
      .getCurrentUser()
      .then((user) => setUser(user))
      .catch((_error) => {})
      .finally(() => setLoadingInitial(false));
  }, []);

  function login(email: string, password: string) {
    setLoading(true);

    sessionsApi
      .login({ email, password })
      .then((user) => {
        setUser(user);
        history.push("/");
      })
      .catch((error) => setError(error))
      .finally(() => setLoading(false));
  }

  function signUp(email: string, name: string, password: string) {
    setLoading(true);

    usersApi
      .signUp({ email, name, password })
      .then((user) => {
        setUser(user);
        history.push("/");
      })
      .catch((error) => setError(error))
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
    [user, loading, error]
  );

  return (
    <AuthContext.Provider value={memoedValue}>
      {!loadingInitial && children}
    </AuthContext.Provider>
  );
}

export default function useAuth() {
  return useContext(AuthContext);
}
