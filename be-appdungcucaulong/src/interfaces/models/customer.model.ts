export interface Customer {
  ID_Customer: number;
  Username: string;
  Email: string;
  Phone: string;
  Address?: string;
  Gender?: string;
  Password: string;
  Avatar?: string;
  Role: 'customer' | 'admin';
}