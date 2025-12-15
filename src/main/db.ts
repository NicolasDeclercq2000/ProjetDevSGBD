import { PrismaClient } from '@prisma/client';

// On crée une seule instance de Prisma pour toute l'application
const prisma = new PrismaClient();

export default prisma;