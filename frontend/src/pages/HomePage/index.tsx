import React from "react";
import useAuth from "root/hooks/useAuth";
import potato from "root/assets/potato.jpg";

import styles from "./index.module.css";

export default function HomePage() {
  const { user, logout } = useAuth();

  return (
    <div className={styles.root}>
      <p>Hello {user!.email}</p>

      <button type="button" onClick={logout}>
        Logout
      </button>

      <img className={styles.image} src={potato} alt="potato" />
    </div>
  );
}
