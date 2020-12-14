import React, { useEffect, useState } from "react";
import redaxios from "redaxios";

export default function ServerResource() {
  const [data, setData] = useState<undefined | any>();
  const [error, setError] = useState<undefined | any>();

  async function fetchExampleData() {
    try {
      const response = await redaxios.get(`/api/example`);

      setData(response.data);
    } catch (error) {
      setError(error);
    }
  }

  useEffect(() => {
    fetchExampleData();
  }, []);

  if (error) return <p>error!</p>

  return data ? <p>API Result: {data.message}</p> : <p>loading</p>;
}
