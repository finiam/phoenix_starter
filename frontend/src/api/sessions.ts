import redaxios from "redaxios";

export async function login(params: {
  email: string;
  password: string;
}): Promise<User> {
  const response = await redaxios.post("/api/sessions", { session: params });

  return response.data.data;
}

export async function logout() {
  const response = await redaxios.delete("/api/sessions");

  return response.data.data;
}
