public class CnpjValidator extends DocumentValidator {

    public CnpjValidator() {
        super(new String[]{
                '00000000000000', '11111111111111', '22222222222222',
                '33333333333333', '44444444444444', '55555555555555',
                '66666666666666', '77777777777777', '88888888888888',
                '99999999999999'
            }
        );
    }

    public override Boolean isValid(String cnpj) {
        cnpj = removeSpecialChars(cnpj);

        if(String.isEmpty(cnpj) || !cnpj.isNumeric() || cnpj.length() != 14 || isSequential(cnpj)) {
            return false;
        }

        Integer firstDigit = calculateVerificationDigit(cnpj, 12, 5);
        Integer secondDigit = calculateVerificationDigit(cnpj, 13, 6);

        return firstDigit == Integer.valueOf(cnpj.substring(12, 13)) 
            && secondDigit == Integer.valueOf(cnpj.substring(13, 14));
    }

    protected override Integer calculateVerificationDigit(String cnpj, Integer length, Integer weightStart) {
        Integer sum = 0;
        Integer weight = weightStart;

        for(Integer i = 0; i < length; i++) {
            Integer num = Integer.valueOf(cnpj.substring(i, i + 1));
            sum += num * weight;
            weight = (weight == 2) ? 9 : weight - 1;
        }

        Integer remainder = 11 - (Math.mod(sum, 11));
        return (remainder < 2) ? 0 : remainder;
    }
}