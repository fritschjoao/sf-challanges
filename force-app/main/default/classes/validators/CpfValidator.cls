public class CpfValidator extends DocumentValidator {

    public CpfValidator() {
        super(new String[]{
                '00000000000', '11111111111', '22222222222',
                '33333333333', '44444444444', '55555555555',
                '66666666666', '77777777777', '88888888888',
                '99999999999'
            }
        );
    }

    public override Boolean isValid(String cpf) {
        cpf = removeSpecialChars(cpf);
    
        if(String.isEmpty(cpf) || !cpf.isNumeric() || cpf.length() != 11 || isSequential(cpf)) {
            return false;
        }

        Integer firstDigit = calculateVerificationDigit(cpf, 9, 10);
        Integer secondDigit = calculateVerificationDigit(cpf, 10, 11);
    
        return firstDigit == Integer.valueOf(cpf.substring(9, 10)) 
            && secondDigit == Integer.valueOf(cpf.substring(10, 11));
    }

    protected override Integer calculateVerificationDigit(String cpf, Integer length, Integer weightStart) {
        Integer sum = 0;
        Integer weight = weightStart;

        for(Integer i = 0; i < length; i++) {
            Integer num = Integer.valueOf(cpf.substring(i, i + 1));
            sum += num * weight;
            weight--;
        }

        Integer remainder = 11 - (Math.mod(sum, 11));
        return (remainder == 10 || remainder == 11) ? 0 : remainder;
    }
}
