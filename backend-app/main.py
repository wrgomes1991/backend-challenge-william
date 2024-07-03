from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel
import jwt  # Usando a biblioteca pyjwt
import re

app = FastAPI()

ALGORITHM = "HS256"

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
    try:
        # Usando pyjwt para decodificar sem verificar a assinatura
        payload = jwt.decode(token, options={"verify_signature": False})
    except jwt.DecodeError:
        raise HTTPException(status_code=401, detail="Invalid token")

    if not all(key in payload for key in ("Name", "Role", "Seed")):
        raise HTTPException(status_code=400, detail="Token must contain exactly 3 claims: Name, Role, Seed")

    name = payload.get("Name")
    role = payload.get("Role")
    seed = int(payload.get("Seed"))

    if not isinstance(name, str) or not name.replace(" ", "").isalpha() or len(name) > 256:
        raise HTTPException(status_code=400, detail="Invalid 'Name' claim")

    if role not in {"Admin", "Member", "External"}:
        raise HTTPException(status_code=400, detail="Invalid 'Role' claim")

    if not is_prime(seed):
        raise HTTPException(status_code=400, detail="Invalid 'Seed' claim")

    return TokenData(name=name, role=role, seed=seed)

@app.get("/verify-token")
def verify_token(token: str = Query(...)):
    token_data = validate_token(token)
    return {"message": "Token is valid", "data": token_data}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
