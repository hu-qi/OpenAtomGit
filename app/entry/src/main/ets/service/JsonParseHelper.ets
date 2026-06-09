export class JsonParseHelper {
  static parseObject<T>(body: string): T | null {
    try {
      return JSON.parse(body) as T;
    } catch (error) {
      return null;
    }
  }

  static parseArray<T>(body: string): T[] {
    try {
      return JSON.parse(body) as T[];
    } catch (error) {
      return [];
    }
  }
}
