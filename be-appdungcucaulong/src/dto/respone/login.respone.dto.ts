export interface LoginResponseDto {
  token: string;
  user: {
    ID_Customer: number;
    Username: string;
    Email: string;
    Phone: string;
    Role: string;
  };
}
