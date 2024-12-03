public abstract class DocumentValidator {

    private String[] sequentialPatterns;

    public DocumentValidator(String[] sequentialPatterns) {
        this.sequentialPatterns = sequentialPatterns;
    }

    protected String removeSpecialChars(String document) {
        return document.replaceAll('[^0-9]', '');
    }

    protected Boolean isSequential(String document) {
        return this.sequentialPatterns.contains(document);
    }

    public abstract Boolean isValid(String document);
    protected abstract Integer calculateVerificationDigit(String document, Integer length, Integer weightStart);
}
