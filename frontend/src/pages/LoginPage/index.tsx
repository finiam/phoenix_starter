import React, { FormEvent } from "react";
import { Link } from "react-router-dom";
import useAuth from "root/hooks/useAuth";

import styles from "./index.module.css";

export default function Login() {
  const { login, loading, error } = useAuth();

  function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const formData = new FormData(event.currentTarget);

    login(formData.get("email") as string, formData.get("password") as string);
  }

  return (
    <form className={styles.root} onSubmit={handleSubmit}>
      <h1>Login</h1>

      <label>
        Email
        <input name="email" />
      </label>

      <label>
        Password
        <input name="password" type="password" />
      </label>

      <button disabled={loading}>Submit</button>

      {error && <p className={styles.error}>Bad login/password</p>}

      <Link to="/sign_up">Sign Up</Link>
    </form>
  );
}
