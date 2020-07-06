export class Type {
    name: string;
    noDamageFrom: string[] = []
    halfDamageFrom: string[] = []
    doubleDamageFrom: string[] = []
    constructor(name: string) {
        this.name = name;
    }
}