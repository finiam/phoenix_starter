import React, { FormEvent } from "react";
import { Link } from "react-router-dom";
import useAuth from "root/hooks/useAuth";

import styles from "./index.module.css";

export default function Login(): JSX.Element {
  const { login, loading, error } = useAuth();

  function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const formData = new FormData(event.currentTarget);

    login(formData.get("email") as string, formData.get("password") as string);
  }

  return (
    <form className={styles.root} onSubmit={handleSubmit}>
      <h1>Login</h1>

      <label htmlFor="email">
        Email
        <input id="email" name="email" />
      </label>

      <label htmlFor="password">
        Password
        <input id="password" name="password" type="password" />
      </label>

      <button disabled={loading} type="submit">
        Submit
      </button>

      {error && <p className={styles.error}>Bad login/password</p>}

      <Link to="/sign_up">Sign Up</Link>
    </form>
  );
}
