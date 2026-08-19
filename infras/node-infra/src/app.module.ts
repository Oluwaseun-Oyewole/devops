import { Module } from '@nestjs/common';
import { ItemsController } from './app.controller';
import { ItemsService } from './app.service';

@Module({
  imports: [],
  controllers: [ItemsController],
  providers: [ItemsService],
})
export class AppModule {}
