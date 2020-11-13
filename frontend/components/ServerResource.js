import React, { useEffect, useState } from "react";
import redaxios from "redaxios";

export default function ServerResource() {
  const [data, setData] = useState();

  async function fetchExampleData() {
    const response = await redaxios.get(`/api/example`);

    setData(response.data);
  }

  useEffect(() => {
    fetchExampleData();
  }, []);

  return data ? <p>API Result: {data.message}</p> : <p>loading</p>;
}
