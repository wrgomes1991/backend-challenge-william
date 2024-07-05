import logging
from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel
import jwt  # Usando a biblioteca pyjwt
import re

app = FastAPI()

ALGORITHM = "HS256"

# Configurando o logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class TokenData(BaseModel):
    name: str
    role: str
    seed: int

def is_prime(n: int) -> bool:
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def validate_token(token: str) -> TokenData:
    logger.info("Validating token.")
    try:
        payload = jwt.decode(token, options={"verify_signature": False})
        logger.info("Token decoded successfully. Payload: %s", payload)
    except jwt.DecodeError:
        logger.error("Failed to decode token.")
        raise HTTPException(status_code=401, detail="Falso")

    if not all(key in payload for key in ("Name", "Role", "Seed")):
        logger.error("Token must contain exactly 3 claims: Name, Role, Seed")
        raise HTTPException(status_code=400, detail="Falso Token must contain exactly 3 claims: Name, Role, Seed")

    name = payload.get("Name")
    role = payload.get("Role")
    try:
        seed = int(payload.get("Seed"))
    except (ValueError, TypeError):
        logger.error("Falso Seed claim is not a valid integer.")
        raise HTTPException(status_code=400, detail="Falso Invalid 'Seed' claim")

    logger.info("Validating claims: Name=%s, Role=%s, Seed=%d", name, role, seed)

    if not isinstance(name, str) or not name.replace(" ", "").isalpha() or len(name) > 256:
        logger.error("Invalid 'Name' claim: %s", name)
        raise HTTPException(status_code=400, detail="Falso Invalid 'Name' claim")

    if role not in {"Admin", "Member", "External"}:
        logger.error("Invalid 'Role' claim: %s", role)
        raise HTTPException(status_code=400, detail="Falso Invalid 'Role' claim")

    if not is_prime(seed):
        logger.error("Invalid 'Seed' claim: %d is not a prime number.", seed)
        raise HTTPException(status_code=400, detail="Falso Invalid 'Seed' claim")

    logger.info("Verdadeiro.")
    return TokenData(name=name, role=role, seed=seed)

@app.get("/verify-token")
def verify_token(token: str = Query(...)):
    logger.info("Received token for verification.")
    token_data = validate_token(token)
    return {"message": "Verdadeiro", "data": token_data}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)

