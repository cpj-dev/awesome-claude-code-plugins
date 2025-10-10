# Code Review Command

Perform a comprehensive code review of recent changes.

## Review Checklist

### 1. Code Quality
- **Readability**: Is the code easy to understand?
- **Maintainability**: Can future developers easily modify this?
- **DRY Principle**: Is there duplicated code that should be extracted?
- **Naming**: Are variables, functions, and classes well-named?

### 2. Functionality
- **Logic Errors**: Are there any logical mistakes?
- **Edge Cases**: Are edge cases handled properly?
- **Error Handling**: Is error handling comprehensive?
- **Input Validation**: Are inputs properly validated?

### 3. Performance
- **Algorithmic Efficiency**: Could algorithms be more efficient?
- **Resource Usage**: Is memory and CPU usage optimal?
- **Database Queries**: Are queries optimized (N+1 problems)?
- **Caching**: Should caching be implemented?

### 4. Security
- **SQL Injection**: Are queries parameterized?
- **XSS**: Is user input sanitized?
- **Authentication**: Is authentication properly implemented?
- **Authorization**: Are permissions checked correctly?
- **Secrets**: Are there any exposed secrets or credentials?

### 5. Testing
- **Test Coverage**: Are new features tested?
- **Test Quality**: Are tests meaningful and thorough?
- **Edge Cases**: Are edge cases tested?

### 6. Documentation
- **Code Comments**: Complex logic explained?
- **API Documentation**: Public APIs documented?
- **README Updates**: Documentation updated?

## Output Format

Provide your review in this structure:

```markdown
# Code Review Report

## ✅ Strengths
[List positive aspects of the code]

## ⚠️ Issues Found

### High Priority
[Critical issues that must be fixed]

### Medium Priority
[Important issues that should be addressed]

### Low Priority
[Nice-to-have improvements]

## 🔧 Specific Recommendations
1. [Actionable recommendation with file:line reference]
2. [Actionable recommendation with file:line reference]

## 📊 Summary
[Brief overall assessment]
```

Be constructive, specific, and include file:line references for all issues.
