function main(params) {
    return {
        statusCode: 200,
        body: params,
        headers: {
            "Cache-Control": "max-age=60"
        }
    }
}
