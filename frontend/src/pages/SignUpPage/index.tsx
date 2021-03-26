import React, { FormEvent } from "react";
import { Link } from "react-router-dom";
import useAuth from "root/hooks/useAuth";

import styles from "./index.module.css";

export default function SignUpPage(): JSX.Element {
  const { signUp, loading, error } = useAuth();

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    const formData = new FormData(event.currentTarget);

    signUp(
      formData.get("email") as string,
      formData.get("name") as string,
      formData.get("password") as string
    );
  }

  return (
    <form className={styles.root} onSubmit={handleSubmit}>
      <h1>Sign up</h1>

      <label htmlFor="id">
        Name
        <input id="name" name="name" />
        {error && <p className={styles.error}>{error.data.errors.name}</p>}
      </label>

      <label htmlFor="email">
        Email
        <input id="email" name="email" type="email" />
        {error && <p className={styles.error}>{error.data.errors.email}</p>}
      </label>

      <label htmlFor="password">
        Password
        <input id="password" name="password" type="password" />
        {error && <p className={styles.error}>{error.data.errors.password}</p>}
      </label>

      <button disabled={loading} type="submit">
        Submit
      </button>

      <Link to="/login">Login</Link>
    </form>
  );
}
