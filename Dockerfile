FROM node:18 AS builder

WORKDIR /code

COPY package.json ./
COPY yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN npm run build

FROM node:18

WORKDIR /app
COPY --from=builder /code/node_modules ./node_modules
COPY --from=builder /code/public ./public
COPY --from=builder /code/.next ./.next
COPY --from=builder /code/package.json .

EXPOSE 3000

CMD ["npm", "start"]
