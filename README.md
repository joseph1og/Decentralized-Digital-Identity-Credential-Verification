# Decentralized Digital Identity Credential Verification System

A comprehensive blockchain-based identity verification system built with Clarity smart contracts for the Stacks blockchain. This system provides a decentralized approach to managing digital identity credentials with built-in verification, revocation, and trust scoring mechanisms.

## 🏗️ System Architecture

The system consists of five interconnected smart contracts:

### 1. Identity Provider Contract (`identity-provider.clar`)
- **Purpose**: Manages trusted identity providers and their verification status
- **Key Features**:
    - Provider registration and verification
    - Public key management
    - Status tracking (pending, verified, revoked)
    - Authority-based verification system

### 2. Credential Schema Contract (`credential-schema.clar`)
- **Purpose**: Standardizes identity claim formats and manages schema definitions
- **Key Features**:
    - Schema creation and versioning
    - Field definition and validation
    - Usage tracking and analytics
    - Required field enforcement

### 3. Verification Protocol Contract (`verification-protocol.clar`)
- **Purpose**: Manages credential confirmation and verification processes
- **Key Features**:
    - Credential submission and verification
    - Signature validation
    - Verification request management
    - Status tracking

### 4. Revocation Registry Contract (`revocation-registry.clar`)
- **Purpose**: Tracks invalidated credentials and manages revocation status
- **Key Features**:
    - Credential revocation with reasons
    - Authority-based revocation system
    - Revocation status checking
    - Emergency restoration capabilities

### 5. Trust Score Contract (`trust-score.clar`)
- **Purpose**: Calculates credential reliability and trust metrics
- **Key Features**:
    - Dynamic trust score calculation
    - Issuer reputation tracking
    - Age-based scoring factors
    - Threshold-based validation

## 🚀 Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd did-verification-system
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks blockchain:

\`\`\`bash
# Deploy identity provider contract
clarinet deploy identity-provider

# Deploy credential schema contract
clarinet deploy credential-schema

# Deploy verification protocol contract
clarinet deploy verification-protocol

# Deploy revocation registry contract
clarinet deploy revocation-registry

# Deploy trust score contract
clarinet deploy trust-score
\`\`\`

## 📋 Usage Examples

### Registering an Identity Provider

\`\`\`clarity
(contract-call? .identity-provider register-provider
"gov-id-provider-001"
"Government ID Provider"
0x03a1b2c3d4e5f6...)
\`\`\`

### Creating a Credential Schema

\`\`\`clarity
(contract-call? .credential-schema create-schema
"basic-identity-v1"
"Basic Identity Schema"
"Standard identity verification schema"
(list "full-name" "date-of-birth" "address" "id-number")
(list "full-name" "id-number"))
\`\`\`

### Submitting a Credential for Verification

\`\`\`clarity
(contract-call? .verification-protocol submit-credential
"cred-12345"
"gov-id-provider-001"
"basic-identity-v1"
u1
0x304502...)
\`\`\`

### Checking Trust Score

\`\`\`clarity
(contract-call? .trust-score get-trust-score "cred-12345")
\`\`\`

## 🔧 API Reference

### Identity Provider Contract

#### Public Functions
- \`register-provider\`: Register a new identity provider
- \`verify-provider\`: Verify an identity provider (owner only)

#### Read-Only Functions
- \`get-provider\`: Get provider information
- \`is-provider-verified\`: Check verification status

### Credential Schema Contract

#### Public Functions
- \`create-schema\`: Create a new credential schema
- \`increment-schema-usage\`: Update usage statistics

#### Read-Only Functions
- \`get-schema\`: Get schema definition
- \`get-schema-usage\`: Get usage statistics
- \`is-schema-valid\`: Validate schema status

### Verification Protocol Contract

#### Public Functions
- \`submit-credential\`: Submit credential for verification
- \`verify-credential\`: Verify a submitted credential
- \`request-verification\`: Request credential verification

#### Read-Only Functions
- \`get-credential-status\`: Get verification status
- \`is-credential-verified\`: Check if credential is verified

### Revocation Registry Contract

#### Public Functions
- \`add-revocation-authority\`: Add revocation authority
- \`revoke-credential\`: Revoke a credential
- \`restore-credential\`: Restore revoked credential (emergency)

#### Read-Only Functions
- \`is-credential-revoked\`: Check revocation status
- \`get-revocation-details\`: Get revocation information
- \`is-revocation-authority\`: Check authority status

### Trust Score Contract

#### Public Functions
- \`calculate-trust-score\`: Calculate credential trust score
- \`update-issuer-reputation\`: Update issuer reputation

#### Read-Only Functions
- \`get-trust-score\`: Get credential trust score
- \`get-issuer-reputation\`: Get issuer reputation
- \`meets-trust-threshold\`: Check trust threshold

## 🧪 Testing

The system includes comprehensive tests using Vitest:

\`\`\`bash
# Run all tests
npm test

# Run specific test file
npm test identity-provider.test.js

# Run tests with coverage
npm run test:coverage
\`\`\`

## 🔒 Security Considerations

1. **Access Control**: All contracts implement proper authorization checks
2. **Data Validation**: Input validation prevents malicious data injection
3. **Signature Verification**: Cryptographic signatures ensure authenticity
4. **Revocation Mechanism**: Immediate credential invalidation capability
5. **Trust Scoring**: Dynamic reputation system prevents abuse

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the documentation wiki

## 🗺️ Roadmap

- [ ] Integration with external identity providers
- [ ] Mobile SDK development
- [ ] Advanced cryptographic features
- [ ] Cross-chain compatibility
- [ ] Privacy-preserving verification methods

