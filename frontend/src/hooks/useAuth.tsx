import React, {
  createContext,
  ReactNode,
  useContext,
  useEffect,
  useState,
} from "react";
import { useHistory } from "react-router-dom";
import { login as apiLogin, logout as apiLogout } from "root/api/sessions";
import { getCurrentUser, signUp as apiSignUp } from "root/api/users";

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

  useEffect(() => {
    getCurrentUser()
      .then((user) => setUser(user))
      .catch((_error) => {})
      .finally(() => setLoadingInitial(false));
  }, []);

  function login(email: string, password: string) {
    setLoading(true);

    apiLogin({ email, password })
      .then((user) => {
        setUser(user);
        history.push("/");
      })
      .catch((error) => setError(error))
      .finally(() => setLoading(false));
  }

  function signUp(email: string, name: string, password: string) {
    setLoading(true);

    apiSignUp({ email, name, password })
      .then((user) => {
        setUser(user);
        history.push("/");
      })
      .catch((error) => setError(error))
      .finally(() => setLoading(false));
  }

  function logout() {
    apiLogout().then(() => setUser(undefined));
  }

  return (
    <AuthContext.Provider
      value={{ user, loading, error, login, signUp, logout }}
    >
      {!loadingInitial && children}
    </AuthContext.Provider>
  );
}

export default function useAuth() {
  return useContext(AuthContext);
}
