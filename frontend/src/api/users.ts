import redaxios from "redaxios";

export async function getCurrentUser(): Promise<User> {
  const response = await redaxios.get("/api/user");

  return response.data.data;
}

export async function signUp(params: {
  email: string;
  name: string;
  password: string;
}): Promise<User> {
  const response = await redaxios.post("/api/user", { user: params });

  return response.data.data;
}
