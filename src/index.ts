import express, { Request, Response } from 'express';

const app = express();
const PORT: number = 3000;

app.get('/', (req: Request, res: Response) => {
  res.send('Hello, TypeScript DevOps World! My TS pipeline is working!');
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});