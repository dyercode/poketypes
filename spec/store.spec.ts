import 'mocha'
import {expect} from 'chai'
import {Type} from "../src/model/type";
import {config, typedex, typedexRaw} from "../src/components/store";
import {get} from 'svelte/store';

const shadowType = {
    name: 'shadow',
    noDamageFrom: [],
    halfDamageFrom: [],
    doubleDamageFrom: []
};
const unknownType = {
    name: 'unknown',
    noDamageFrom: [],
    halfDamageFrom: [],
    doubleDamageFrom: []
};
const fireType = {
    name: 'fire',
    noDamageFrom: [],
    halfDamageFrom: [],
    doubleDamageFrom: []
};
const someTypes: Type[] = [
    shadowType,
    unknownType,
    fireType
]

describe('typedex', () => {
    beforeEach(() => {
        typedexRaw.set(someTypes);
    });

    describe('defaults to hiding shadow and unknown', () => {
        it('does not include shadow', () => {
            expect(get(typedex)).not.to.include(shadowType);
        });

        it('does not include unknown', () => {
            expect(get(typedex)).not.to.include(unknownType);
        });
    });

    describe('shadow', () => {
        describe('when useShadow config is false', () => {
            beforeEach(() => {
                config.set({useShadow: false, useUnknown: true});
            });

            it('hides shadow', () => {
                expect(get(typedex)).not.to.include(shadowType);
            });

            it('still includes other ', () => {
                expect(get(typedex)).to.include(fireType);
            })
        });

        it('can be shown', () => {
            config.set({useShadow: true, useUnknown: true});
            expect(get(typedex)).to.include(shadowType);
        });
    });
    describe('unknown', () => {
        describe('when useUnknown config is false', () => {
            beforeEach(() => {
                config.set({useShadow: true, useUnknown: false});
            });

            it('hides unknown', () => {
                expect(get(typedex)).not.to.include(unknownType);
            });

            it('still includes other ', () => {
                expect(get(typedex)).to.include(fireType);
            })
        });

        it('can be shown', () => {
            config.set({useShadow: true, useUnknown: true});
            expect(get(typedex)).to.include(unknownType);
        });
    });
});
