import { IsEmail, IsNotEmpty, IsString, Matches } from 'class-validator';

export class RegisterCustomerDto {
  @IsNotEmpty({ message: 'Username is required' })
  @IsString()
  username: string | undefined;

  @IsEmail({}, { message: 'Invalid email format' })
  email: string | undefined;

  @IsNotEmpty({ message: 'Phone is required' })
  @IsString()
  phone: string | undefined;

  @IsNotEmpty({ message: 'Password is required' })
  @IsString()
  password: string | undefined;
}
